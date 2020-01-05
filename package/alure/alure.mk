################################################################################
#
# alure
#
################################################################################

ALURE_VERSION = 14beed2a86d5a36030e907b21c46614d505f07cd
ALURE_SITE = $(call github,kcat,alure,$(ALURE_VERSION))
ALURE_LICENSE = Zlib, Public Domain (src/decoders/dr_flac.h)
ALURE_LICENSE_FILES = LICENSE
ALURE_INSTALL_STAGING = YES

ALURE_DEPENDENCIES = openal

# Disabling alure examples remove the dependecies on physfs and dump libraries.
# Enable at least one built-in decoder (wave).
ALURE_CONF_OPTS = -DALURE_INSTALL=ON \
	-DALURE_BUILD_EXAMPLES=OFF \
	-DALURE_ENABLE_MINIMP3=OFF \
	-DALURE_ENABLE_WAVE=ON

ifeq ($(BR2_PACKAGE_ALURE_FLAC_DECODER),y)
ALURE_CONF_OPTS += -DALURE_ENABLE_FLAC=ON
else
ALURE_CONF_OPTS += -DALURE_ENABLE_FLAC=OFF
endif

ifeq ($(BR2_PACKAGE_ALURE_OPUS_DECODER),y)
ALURE_CONF_OPTS += -DALURE_ENABLE_OPUS=ON
ALURE_DEPENDENCIES += libogg opus
else
ALURE_CONF_OPTS += -DALURE_ENABLE_OPUS=OFF
endif

ifeq ($(BR2_PACKAGE_ALURE_SNDFILE_DECODER),y)
ALURE_CONF_OPTS += -DALURE_ENABLE_SNDFILE=ON
ALURE_DEPENDENCIES += libsndfile
else
ALURE_CONF_OPTS += -DALURE_ENABLE_SNDFILE=OFF
endif

ifeq ($(BR2_PACKAGE_ALURE_VORBIS_DECODER),y)
ALURE_CONF_OPTS += -DALURE_ENABLE_VORBIS=ON
ALURE_DEPENDENCIES += libogg libvorbis
else
ALURE_CONF_OPTS += -DALURE_ENABLE_VORBIS=OFF
endif

ifeq ($(BR2_STATIC_LIBS),y)
ALURE_CONF_OPTS += -DALURE_BUILD_SHARED=OFF \
	-DALURE_BUILD_STATIC=ON
else ifeq ($(BR2_SHARED_STATIC_LIBS),y)
ALURE_CONF_OPTS += -DALURE_BUILD_SHARED=ON \
	-DALURE_BUILD_STATIC=ON
else
ALURE_CONF_OPTS += -DALURE_BUILD_SHARED=ON \
	-DALURE_BUILD_STATIC=OFF
endif

$(eval $(cmake-package))
